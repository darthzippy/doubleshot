#!/usr/bin/env jruby

# encoding: utf-8

require_relative "../helper"

describe Doubleshot::Resolver::JarResolver do
  before do
    @resolver = Doubleshot::Resolver::JarResolver.new(*Doubleshot::current.config.mvn_repositories)
  end

  describe "fetch" do
    before do
      @dependencies = Doubleshot::Dependencies::JarDependencyList.new
      @dependencies.fetch("ch.qos.logback:logback-core:jar:1.0.6")
    end

    it "must return the same JarDependencyList" do
      @resolver.resolve!(@dependencies).must_be_same_as @dependencies
    end

    it "must take a JarDependencyList and populate the path of each JarDependency" do
      @resolver.resolve!(@dependencies).each do |dependency|
        dependency.path.wont_be_nil
      end
    end
  end
end