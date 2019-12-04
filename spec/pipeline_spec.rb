require "spec_helper"

describe "pipeline" do
  let(:cluster) { "live-1.cloud-platform.service.justice.gov.uk" }
  let(:success) { double(success?: true) }
  let(:failure) { double(success?: false) }

  let(:env_vars) {
    {
      "PIPELINE_STATE_BUCKET" => "bucket",
      "PIPELINE_STATE_KEY_PREFIX" => "key-prefix/",
      "PIPELINE_TERRAFORM_STATE_LOCK_TABLE" => "lock-table",
      "PIPELINE_STATE_REGION" => "region",
      "TF_VAR_cluster_name" => cluster,
      "TF_VAR_cluster_state_bucket" => "cloud-platform-terraform-state",
      "TF_VAR_cluster_state_key" => "cloud-platform/live-1/terraform.tfstate",
    }
  }

  let(:files) {
    "bin/namespace-reporter.rb
namespaces/#{cluster}/court-probation-preprod/resources/dynamodb.tf
namespaces/#{cluster}/offender-management-staging/resources/elasticache.tf
namespaces/#{cluster}/licences-prod/07-certificates.yaml
namespaces/#{cluster}/pecs-move-platform-backend-staging/00-namespace.yaml
namespaces/#{cluster}/offender-management-preprod/resources/elasticache.tf
namespaces/#{cluster}/poornima-dev/resources/elasticsearch.tf"
  }

  let(:namespaces) {
    [
      "court-probation-preprod",
      "licences-prod",
      "offender-management-preprod",
      "offender-management-staging",
      "pecs-move-platform-backend-staging",
      "poornima-dev",
    ]
  }

  let(:namespace_dirs) { namespaces.map { |namespace| "namespaces/#{cluster}/#{namespace}" } }
  let(:namespace) { "mynamespace" }
  let(:dir) { "namespaces/#{cluster}/#{namespace}" }

  let(:tf) { double(Terraform) }

  it "runs terraform plan" do
    allow(FileTest).to receive(:directory?).and_return(true)
    expect(Terraform).to receive(:new).with(cluster: cluster, namespace: namespace, dir: dir).and_return(tf)
    expect(tf).to receive(:plan)

    plan_namespace_dir(cluster, dir)
  end

  it "sets kube context" do
    cmd = "kubectl config use-context #{cluster}"
    expect(Open3).to receive(:capture3).with(cmd).and_return(["", "", success])
    expect($stdout).to receive(:puts).at_least(:once)

    set_kube_context(cluster)
  end

  it "applies cluster-level kubernetes files" do
    cmd = "kubectl apply -f namespaces/#{cluster}"
    expect(Open3).to receive(:capture3).with(cmd).and_return(["", "", success])
    expect($stdout).to receive(:puts).at_least(:once)

    apply_cluster_level_resources(cluster)
  end

  it "lists namespace dirs" do
    dirs = double(Array)
    expect(Dir).to receive(:[]).with("namespaces/#{cluster}/*").and_return(dirs)
    expect(dirs).to receive(:sort)

    all_namespace_dirs(cluster)
  end

  context "apply_namespace_dir" do
    let(:namespace) { "mynamespace" }
    let(:dir) { "namespaces/#{cluster}/#{namespace}" }

    context "when called with a filename" do
      let(:dir) { $0 } # $0 == name of this specfile

      before do
        allow(FileTest).to receive(:directory?).and_return(false)
      end

      it "does nothing" do
        expect(Open3).to_not receive(:capture3)
        apply_namespace_dir(cluster, dir)
      end
    end

    context "when called with a directory" do
      before do
        allow(FileTest).to receive(:directory?).and_return(true)
      end

      context "with no kubernetes files" do
        it "does not run kubectl apply" do
          allow_any_instance_of(Object).to receive(:apply_terraform)

          cmd = "kubectl -n #{namespace} apply -f namespaces/#{cluster}/#{namespace}"
          expect(Open3).to_not receive(:capture3).with(cmd)

          apply_namespace_dir(cluster, dir)
        end
      end

      context "with kubernetes files" do
        before do
          allow(Dir).to receive(:glob).with("namespaces/live-1.cloud-platform.service.justice.gov.uk/mynamespace/*.{yaml,yml,json}")
            .and_return([1,2,3])
        end

        it "runs kubectl apply" do
          allow_any_instance_of(Object).to receive(:apply_terraform)

          cmd = "kubectl -n #{namespace} apply -f namespaces/#{cluster}/#{namespace}"

          expect_execute(cmd, "", success)
          expect($stdout).to receive(:puts)

          apply_namespace_dir(cluster, dir)
        end
      end


      it "applies terraform files" do
        allow_any_instance_of(Object).to receive(:apply_kubernetes_files).and_return(nil)

        allow(FileTest).to receive(:directory?).and_return(true)
        expect(Terraform).to receive(:new).with(cluster: cluster, namespace: namespace, dir: dir).and_return(tf)
        expect(tf).to receive(:apply)

        apply_namespace_dir(cluster, dir)
      end
    end
  end

  it "get namespaces changed by pr" do
    expect(ENV).to receive(:fetch).with("master_base_sha").and_return("master")
    expect(ENV).to receive(:fetch).with("branch_head_sha").and_return("branch")

    cmd = "git diff --no-commit-id --name-only -r master...branch"
    expect_execute(cmd, files, success)
    expect($stdout).to receive(:puts).at_least(:once)

    expect(changed_namespace_dirs_for_plan(cluster)).to eq(namespace_dirs)
  end

  context "changed_namespace_dirs" do
    let(:cmd) { "git diff --no-commit-id --name-only -r HEAD~1..HEAD" }

    it "gets dirs from latest commit" do
      expect_execute(cmd, files, success)
      expect($stdout).to receive(:puts).with(files)
      expect(changed_namespace_dirs(cluster)).to eq(namespace_dirs)
    end
  end

  context "execute" do
    let(:cmd) { "ls" }

    it "executes and returns status" do
      expect_execute(cmd, "", success)
      execute(cmd)
    end

    it "logs" do
      expect_execute(cmd, "", success)
      execute(cmd)
    end

    context "on failure" do
      it "raises an error" do
        expect_execute(cmd, "", failure)
        expect($stdout).to receive(:puts).with("\e[31mCommand: #{cmd} failed.\e[0m")
        expect { execute(cmd) }.to raise_error(RuntimeError)
      end

      it "does not raise if can_fail is set" do
        expect_execute(cmd, "", failure)
        expect { execute(cmd, can_fail: true) }.to_not raise_error
      end
    end
  end

  context "log" do
    context "green" do
      let(:colour) { "green" }
      let(:message) { "green message" }

      specify {
        expect($stdout).to receive(:puts).with("\e[32m#{message}\e[0m")
        log(colour, message)
      }
    end

    context "blue" do
      let(:colour) { "blue" }
      let(:message) { "blue message" }

      specify {
        expect($stdout).to receive(:puts).with("\e[34m#{message}\e[0m")
        log(colour, message)
      }
    end

    context "red" do
      let(:colour) { "red" }
      let(:message) { "red message" }

      specify {
        expect($stdout).to receive(:puts).with("\e[31m#{message}\e[0m")
        log(colour, message)
      }
    end

    context "unknown colour" do
      let(:colour) { "puce" }
      let(:message) { "wibble" }

      specify {
        expect {
          log(colour, message)
        }.to raise_error(RuntimeError, "Unknown colour puce passed to 'log' method")
      }
    end
  end
end
