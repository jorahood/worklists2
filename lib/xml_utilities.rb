require 'net/http'

module XmlUtilities

  WL1_URL = 'https://kbhandbook.indiana.edu/worklist'
  #   WL1_URL = "https://paprika.uits.indiana.edu/~jorahood/cgi-bin/doclists/cgi-bin/worklist.cgi"
  WL1ListIndex = WL1_URL + "/listids"
  
  @@rest_login = {
    :username_production => 'kbdevtest',
    :password_production => 'EKQ6JNSC5A',
    :username_development => 'kbdevtest',
    :password_development => 'EKQ6JNSC5A',
    :username_test => 'kbdevtest',
    :password_test => 'EKQ6JNSC5A'
  }.with_indifferent_access #use symbols or strings as keys to retrieve values

  def self.clone_all_v1_lists
    lists = []
    lists = get_all_list_ids
    if !lists.empty?
      lists.each do |list_id|
        list = List.find_by_wl1_clone(list_id)
        if list.nil?
          list = List.create!(:wl1_clone => list_id)
        else
          list.save!
        end
      end
    end
  end

  def self.config_ssl(transfer)
    transfer.use_ssl = true
    transfer.ssl_timeout = 2
    transfer.verify_mode = OpenSSL::SSL::VERIFY_PEER
    transfer.verify_depth = 2
  end

  def self.fetch_url(url_string)
    url = URI.parse(url_string)
    transfer = Net::HTTP.new(url.host,url.port)
    XmlUtilities.config_ssl(transfer) if url.scheme == 'https'
    response = transfer.start do |connect|
      connect.get(url.path)
    end
    case response
    when Net::HTTPSuccess then response.body
    else response.error!
    end
  end

  def self.get_all_list_ids
    text = fetch_url(WL1ListIndex)
    text.split("\n")
  end

  def rest_path
    @rest_path = "/REST/v0.2//document/#{docid}.xml?domain=kbstaff"
  end

  def kbxml
    @kbxml ||= request_kbxml
  end

  def to_xml
    kbxml
  end
  
  def request_and_load_yaml(wl1_id)
    url = "#{WL1_URL}/#{wl1_id}/yaml"
    text = XmlUtilities.fetch_url(url)
    YAML.load(text)
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