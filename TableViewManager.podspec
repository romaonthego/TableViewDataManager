Pod::Spec.new do |s|
  s.name             = "TableViewManager"
  s.version          = "1.0.0"
  s.summary          = "A short description of TableViewManager."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/romanthego/TableViewManager"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Roman Efimov" => "romefimov@gmail.com" }
  s.source           = { :git => "https://github.com/romaonthego/TableViewManager.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/romaonthego'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/Classes/**/*'
  s.resources = 'Source/Assets/TableViewManager.bundle'
end
