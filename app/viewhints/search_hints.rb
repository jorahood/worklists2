class SearchHints < Hobo::ViewHints

  field_names :birthdate => "&nbsp;",
    :modifieddate => '&nbsp;',
    :approveddate => '&nbsp;',
    :expiredate => '&nbsp;',
    :birthdate_is => 'Birthdate',
    :modifieddate_is => 'Modifieddate',
    :approveddate_is => 'Approveddate',
    :expiredate_is => 'Expiredate',
    :status => "&nbsp;",
    :importance => "&nbsp;",
    :volatility => "&nbsp;",
    :visibility => "&nbsp;",
    :status_is => "Status",
    :importance_is => "Importance",
    :volatility_is => "Volatility",
    :visibility_is => "Visibility"
end
