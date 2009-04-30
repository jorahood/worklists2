module CustomMatchers

  #checks that an AR model validates, by testing error messages from .valid?
  #displays any error messages recieved in test failure output.
  #http://nubyonrails.wordpress.com/2008/02/07/creating-a-custom-be_valid-matcher-for-rspec_on_rails/
  
  class BeValid
    #do any setup required - at the very least, set some instance variables.
    #In this case, i don't take any arguments - it simply either passes or fails.
    def initialize
      @expected = []
    end

    #perform the actual match - 'target' is the thing being tested
    def matches?(target)
      #target.errors.full_messages is an array of error messages produced by the valid? method
      #if valid? is true, it will be empty
      target.valid?
      @errors = target.errors.full_messages
      @errors.eql?(@expected)
    end

    #displayed when 'should' fails
    def failure_message
      "validation failed with #{@errors.inspect}, expected no validation errors"
    end

    #displayed when 'should_not' fails
    def negative_failure_message
      "validation succeeded, expected one or more validation errors"
    end

    #displayed in the spec description if the user doesn't provide one (ie if they just write 'it do' for the spec header)
    def description
      "validate successfully"
    end

    # Returns string representation of the object being tested
    def to_s(value)
      "#{@errors.inspect}"
    end
  end

  # the matcher method that the user calls in their specs
  def be_valid
    BeValid.new
  end
end
