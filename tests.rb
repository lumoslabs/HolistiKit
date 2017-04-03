#!/usr/bin/env ruby

DEVICE = "iPhone 7"
IOS_VERSION = "10.1"

def run(command)
  puts(command)
  @any_failures ||= !system(command)
end

def xcodebuildCommand(command)
  if command == :build then
    "clean build"
  elsif command == :test then
    "test"
  else
    raise "Unhandled xcodebuild command"
  end
end

def xcodebuildCodeCoverage(command)
  # Disabling code coverage for now. Xcode 8.3 crashes during
  # compilation with a custom main.swift if code coverage is enabled
  #command == :test ? "-enableCodeCoverage YES" : ""
  return ""
  #
end

def xcodebuildScheme(scheme)
  if [:ExampleApp, :UIKitFringes, :SpecUIKitFringes].include? scheme
    scheme
  else
    raise "Unhandled xcodebuild scheme"
  end
end

def xcodebuild(command, scheme)
  run "set -o pipefail && \
    xcodebuild #{xcodebuildCommand(command)} \
      -workspace HolistiKit.xcworkspace \
      -scheme '#{xcodebuildScheme(scheme)}' \
      -destination 'platform=iOS Simulator,name=#{DEVICE},OS=#{IOS_VERSION}' \
      #{xcodebuildCodeCoverage(command)} \
    | xcpretty"
end

[:SpecUIKitFringes, :UIKitFringes, :ExampleApp].each do |scheme|
  xcodebuild(:build, scheme)
  xcodebuild(:test, scheme)
end

if @any_failures then
  raise "Tests failed"
end

