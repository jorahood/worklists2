require File.expand_path(File.dirname(__FILE__) + '/textmate_formatter')

class JiraLinksFormatter < TextmateFormatter

  def visit_tag_name(tag_name)
    @builder.text!(@tag_spacer) if @tag_spacer
    @tag_spacer = ' '
    if tag_name.match /^([A-Z]+-\d+)$/
      @builder.span(:class => 'tag') do
        @builder.a( { :href => "https://uisapp2.iu.edu/jira-prd/browse/#{$1}"}, "@Jira Ticket: "+$1 )
      end
    else
      @builder.span("@#{tag_name}", :class => 'tag')
    end
  end

end
