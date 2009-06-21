class SearchHints < Hobo::ViewHints

  field_names :birthdate => "&nbsp;",
    :modifieddate => '&nbsp;',
    :approveddate => '&nbsp;',
    :expiredate => '&nbsp;',
    :birthdate_is => 'Born',
    :modifieddate_is => 'Modified',
    :approveddate_is => 'Approved',
    :expiredate_is => 'Expires'
end
