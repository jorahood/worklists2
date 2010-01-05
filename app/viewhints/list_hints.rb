class ListHints < Hobo::ViewHints
  children :listed_docs
  field_names :show_boilers => "Show Boiler Name",
    :wl1_import => "Import v1 Worklist",
    :wl1_clone => "Clone v1 Worklist"
end
