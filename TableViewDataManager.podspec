Pod::Spec.new do |s|
  s.name             = "TableViewDataManager"
  s.version          = "0.1.0"
  s.summary          = "A short description of TableViewDataManager."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/romanthego/TableViewDataManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Roman Efimov" => "romefimov@gmail.com" }
  s.source           = { :git => "https://github.com/romaonthego/TableViewDataManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/romaonthego'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/Classes/**/*'
  s.resources = 'Source/Assets/TableViewDataManager.bundle'
end
