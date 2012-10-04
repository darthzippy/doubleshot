#!/usr/bin/env jruby

require_relative "helper"

describe Doubleshot::Compiler do

  it "must accept source and target paths" do
    compiler = Doubleshot::Compiler.new "ext/java", "target"
    compiler.source.must_equal Pathname("ext/java")
    compiler.target.must_equal Pathname("target")
  end

  it "must compile a cow" do
    Helper::tmp do |tmp|
      source = tmp + "java"
      source.mkdir

      target = tmp + "target"
      target.mkdir

      (source + "Cow.java").open("w+") do |cow|
        cow << <<-EOS.margin
        package org.sam.doubleshot;

        public class Cow {
          public Cow() {}

          public String moo() {
            return "MOO!";
          }
        }
        EOS
      end

      Doubleshot::Compiler.new(source, target).build!

      cow = target + "org/sam/doubleshot/Cow.class"
      cow.must :exist

      org.sam.doubleshot.Cow.new.moo.must_equal "MOO!"
    end
  end

end