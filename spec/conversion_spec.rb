require File.dirname(__FILE__) + '/spec_helper.rb'

describe RubyPython::Conversion do
  include RubyPythonStartStop
  include TestConstants

  subject { RubyPython::Conversion }

  before do
    sys = RubyPython.import 'sys'
    sys.path = ['./spec/python_helpers']
    @objects = RubyPython.import 'objects'
  end

  context "when converting from Python to Ruby" do
    [
      ["an int", "an int", AnInt],
      ["a float", "a float", AFloat],
      ["a string", "a string", AString],
      ["a list", "an array", AnArray],
      ["a dict", "a hash", AConvertedHash]
    ].each do |py_type, rb_type, output|
      it "should convert #{py_type} to #{rb_type}" do
        py_object_ptr = @objects.__send__(py_type.sub(' ', '_')).pObject.pointer
        subject.ptorObject(py_object_ptr).should == output
      end
    end

  end

end
