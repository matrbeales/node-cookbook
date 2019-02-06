#
# Cookbook:: node
# Spec:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'node::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "should install nginx" do
      expect(chef_run).to install_package("nginx")
    end

    it "should enable ngninx as a service" do
      expect(chef_run).to enable_service("nginx")
    end

    it "should start ngninx as a service" do
      expect(chef_run).to start_service("nginx")
    end

    it "should install nodejs from a recipe" do
      expect(chef_run).to include_recipe("nodejs")
    end

    it "should install pm2 via npm" do
      expect(chef_run).to install_nodejs_npm("pm2")
    end

    it "should create a nginx.conf template in /etc/nginx" do
      expect(chef_run).to create_template("/etc/nginx/nginx.conf").with_variables(proxy_port: 3000)
    end

  end
end
