require 'casclient'
require 'casclient/frameworks/rails/filter'

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => 'https://cas.iu.edu/cas/',
  # Re: 'cassvc' param, see https://kb.iu.edu/data/alqm.html and
  :login_url => 'https://cas.iu.edu/cas/login?cassvc=ANY',
  :validate_url => 'https://cas.iu.edu/cas/validate?cassvc=ANY'
)
