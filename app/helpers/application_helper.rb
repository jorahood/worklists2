# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def revision_name
    svn_branch || git_branch || 'worklists2'
  end

  def svn_branch
    /^URL: .*\/(\S+?\/\S+?)$/.match(`svn info`) ? $1 : nil
  end

  def git_branch
#    /^\* (\S+?)$/.match(`git branch`) ? $1 : nil
  nil
  end
end
