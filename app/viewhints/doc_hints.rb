class DocHints < Hobo::ViewHints

  #including all the child collections for tha aside section here as a reference
  #for customization. They cause the <aside> param section in the <def tag="show-page" for="Doc">
  #in pages.dryml to be generated, which I'm customizing in views/docs/show.dryml to only
  #show aside collections that have members.
  children :titles, :domains, :hotitems, :expirations, :resources, :referenced_boilers, :boilers, :refs, :refbys, :xtras#, :lists
  field_names :importance_assoc => 'Importance',
      :visibility_assoc => 'Visibility',
      :volatility_assoc => 'Volatility',
      :status_assoc => 'Status',
      :author_assoc => 'Author',
      :owner_assoc => 'Owner'
end
