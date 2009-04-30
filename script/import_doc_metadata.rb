#!/usr/bin/env ruby
require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../config/environment'
require 'ar-extensions'
# the following lines required as of 0.8.0: 
# http://www.continuousthinking.com/2008/8/16/ar-extensions-0-8-0-forgot-to-mention
require 'ar-extensions/adapters/mysql'
require 'ar-extensions/import/mysql'

class MasterDoc < ActiveRecord::Base
  # FIXME: need a check here to make sure the ssh tunnel is available
  establish_connection :master_docs
end

def import_docs
  values = MasterDoc.connection.select_rows('SELECT * FROM documentview')
  # the columns command returns the columns in a different order than the values
  # above. useless. oracle_enhanced_adapter doesn't have a column_names method
  # like ActiveRecord::Base, so if this did work I'd have to extract them myself

  #columns = MasterDoc.connection.columns('documentview')
  #column_names = [columns.map {|col| col.name}]

  column_names =
    ['status',
    'visibility',
    'modifieddate',
    'birthdate',
    'author',
    'id',
    'owner',
    'volatility',
    'importance',
    'approveddate']

  # FIXME: is this establish_connection necessary? I think Doc will inherit the
  # default ActiveRecord::Base connection
  Doc.establish_connection
  Doc.import column_names, values, :on_duplicate_key_update => column_names, :validate => false
end

def import_titles
  values = MasterDoc.connection.select_rows('SELECT * FROM titlecache')
  #values[0].each{|field|puts field}

  column_names = ['doc_id','title','audience_id']
  Title.establish_connection
  Title.import column_names, values, :on_duplicate_key_update => [:title], :validate => false
end

def import_audiences
  values = MasterDoc.connection.select_rows('SELECT * FROM titleaudience')

  column_names = ['description','id']
  Audience.establish_connection
  Audience.import column_names, values, :on_duplicate_key_update => column_names, :validate => false
end

def import_domains
  values = MasterDoc.connection.select_rows('SELECT * FROM domainlist')
  return values[0].each{|field|puts field + "\n"}

  column_names = ['accessible','visible','class','type','id','description','audience']
  Domain.establish_connection
  Domain.import column_names, values, :on_duplicate_key_update => column_names, :validate => false
end
#import_docs
#import_titles
#import_audiences
import_domains