require 'helper'

describe '.split_parameters' do
  before :each do
    ARGV.clear
    Cukesparse.reset!
  end

  context "when run with arguments and :screen symbol" do
    it "will return set a parameters screen key and value" do
      Cukesparse.split_parameters('1024/1280', 'screen')
      Cukesparse.parameters.should have_key('screenwidth')
      Cukesparse.parameters.should have_key('screenheight')
      Cukesparse.parameters['screenwidth'].should eql "SCREENWIDTH=1024"
      Cukesparse.parameters['screenheight'].should eql "SCREENHEIGHT=1280"
    end
  end

  context "when run with arguments and :position symbol" do
    it "will return set a parameters screen key and value" do
      Cukesparse.split_parameters('0/100', 'position')
      Cukesparse.parameters.should have_key('xposition')
      Cukesparse.parameters.should have_key('yposition')
      Cukesparse.parameters['xposition'].should eql "XPOSITION=0"
      Cukesparse.parameters['yposition'].should eql "YPOSITION=100"
    end
  end

  context "when run with one argument" do
    it "will return a you have passed enough parameters error" do
      Cukesparse.should_receive("abort").with("ERROR: You have not passed enough parameters in the test command line argument!".red.underline)
      Cukesparse.split_parameters('1024', 'test')
    end
  end

  context "when run with over two argument" do
    it "will return a you have passed to many parameters error" do
      Cukesparse.should_receive("abort").with("ERROR: You have passed to many parameters in the test command line argument!".red.underline)
      Cukesparse.split_parameters('1024/1280/16', 'test')
    end
  end
end