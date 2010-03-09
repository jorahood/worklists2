class ListHints < Hobo::ViewHints
  children :listed_docs
  field_names :show_boilers => "Show Boiler Name",
    :custom_url => "Custom URL",
    :wl1_import => "Import v1 Worklist",
    :wl1_clone => "Clone v1 Worklist"

  field_help :custom_url => 'Enter the url for docid links, using "%k" in place of the docid; e.g., https://kb.iu.edu/data/%k.html'
end
