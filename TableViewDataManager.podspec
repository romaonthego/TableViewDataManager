Pod::Spec.new do |s|
  s.name             = "TableViewDataManager"
  s.version          = "0.1.0"
  s.summary          = "Powerful data driven content manager for UITableView written in Swift."
  s.description      = "Powerful data driven content manager for UITableView written in Swift."
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
