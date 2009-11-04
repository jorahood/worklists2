require 'net/http'

module XmlUtilities

  @@rest_login = {
    :username_production => 'kbdevtest',
    :password_production => 'EKQ6JNSC5A',
    :username_development => 'kbdevtest',
    :password_development => 'EKQ6JNSC5A',
    :username_test => 'kbdevtest',
    :password_test => 'EKQ6JNSC5A'
  }.with_indifferent_access #use symbols or strings as keys to retrieve values

  def rest_path
    @rest_path = "/REST/v0.2//document/#{docid}.xml?domain=kbstaff"
  end

  def kbxml
    @kbxml ||= request_kbxml
  end

  def to_xml
    kbxml
  end
  
  def kbxml_body
    kbxml =~ /(<kbml .*<\/kbml>)/m
    $1
  end
  def request_kbxml
    http = Net::HTTP.new('remote.kb.iu.edu')
    http.start do |connection|
      action = Net::HTTP::Get.new(rest_path)
      action.basic_auth(@@rest_login["username_#{RAILS_ENV}"], @@rest_login["password_#{RAILS_ENV}"])
      response = connection.request(action)
      response.value
      response.body
    end
  end

end