class DocHints < Hobo::ViewHints

  children :titles, :domains, :hotitems, :expirations, :resources, :referenced_boilers, :boilers, :refs, :refbys, :xtras#, :lists
  field_names :importance_assoc => 'Importance',
      :visibility_assoc => 'Visibility',
      :volatility_assoc => 'Volatility',
      :status_assoc => 'Status',
      :author_assoc => 'Author',
      :owner_assoc => 'Owner'
end
