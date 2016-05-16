Pod::Spec.new do |s|
  s.name             = "TableViewDataManager"
  s.version          = "0.1.4"
  s.summary          = "Powerful data driven content manager for UITableView written in Swift."
  s.description      = <<-DESC
`TableViewDataManager` allows to manage the content of any `UITableView` with ease, both forms and lists. `TableViewDataManager` is built on top of reusable cells technique and provides APIs for mapping any object class to any custom cell subclass.

The general idea is to allow developers to use their own `UITableView` and `UITableViewController` instances (and even subclasses), providing a layer that synchronizes data with the cell appereance.
It fully implements `UITableViewDelegate` and `UITableViewDataSource` protocols so you don't have to.
                       DESC
  s.homepage         = "https://github.com/romaonthego/TableViewDataManager"
  s.license          = 'MIT'
  s.author           = { "Roman Efimov" => "romefimov@gmail.com" }
  s.source           = { :git => "https://github.com/romaonthego/TableViewDataManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/romaonthego'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/Classes/**/*'
  s.resources = 'Source/Assets/TableViewDataManager.bundle'
end
