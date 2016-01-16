require "spec_helper"

describe "nginx::default" do
  let(:apt_source) do
    "/etc/apt/sources.list.d/nginx.list"
  end

  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it { expect(chef_run).to add_apt_repository("nginx") }
  it { expect(chef_run).to install_package("nginx") }
  it { expect(chef_run).to enable_service("nginx") }
  it { expect(chef_run).to start_service("nginx") }

  it "creates directories" do
    expect(chef_run).to create_directory("/etc/nginx").with(owner: "root", group: "root", mode: "0755")
    expect(chef_run).to create_directory("/etc/nginx/sites-enabled").with(owner: "root", group: "root", mode: "0755")
    expect(chef_run).to create_directory("/etc/nginx/sites-available").with(owner: "root", group: "root", mode: "0755")
    expect(chef_run).to create_directory("/var/log/nginx").with(owner: "www-data", group: "adm", recursive: true)
  end

  it "creates main nginx.conf" do
    expect(chef_run).to create_template("/etc/nginx/nginx.conf").with(
      source: "nginx.conf.erb",
      owner: "root",
      group: "root",
      mode:  "0644"
    )

    file = chef_run.template("/etc/nginx/nginx.conf")
    expect(file).to notify("service[nginx]").to(:restart)
  end

  it "creates mime types file" do
    expect(chef_run).to create_cookbook_file("/etc/nginx/mime.types").with(
      source: "mime.types",
      owner: "root",
      group: "root",
      mode:  "0644"
    )

    file = chef_run.cookbook_file("/etc/nginx/mime.types")
    expect(file).to notify("service[nginx]").to(:restart)
  end

  context "default site" do
    context "when `skip_default_site` is true" do
      let(:chef_run) do
        ChefSpec::SoloRunner.new do |node|
          node.set["nginx"]["skip_default_site"] = true
        end.converge(described_recipe)
      end

      it "disables the default site" do
        expect(chef_run).to_not create_nginx_site("default")
      end

      it "does not create the `default` template" do
        expect(chef_run).to_not create_template("default")
      end

      it "removes the default site configuration" do
        expect(chef_run).to delete_file("/etc/nginx/sites-enabled/default")
      end
    end
  end

  it "removes default in conf.d" do
    expect(chef_run).to delete_file("/etc/nginx/conf.d/default")
  end
end
