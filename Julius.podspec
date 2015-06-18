Pod::Spec.new do |s|
  s.name             = "Julius"
  s.version          = "4.3.1"
  s.summary          = "A short description of Julius."
  s.description      = <<-DESC
                       An optional longer description of Julius

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/guccyon/Julius-Pod"
  s.license          = { file: "julius-#{s.version}/LICENSE.utf8.txt" }
  s.author           = { "Tetsuro Higuchi" => "higuchi.tetsuro[at]gmail.com" }
  s.source           = { :git => "https://github.com/guccyon/Julius-Pod.git", :tag => s.version.to_s }

  s.platform         = :ios, '7.0'
  s.requires_arc     = true


  s.source_files = 'Pod/Classes/**/*.{h,m}',
                   'Pod/Headers/**/*.{h,m}'

  s.prepare_command = <<-CMD
    sh configure-ios.sh
  CMD

  s.subspec 'libsent' do |sub|
    source_root = "julius-#{s.version}/libsent"

    exclude_adin_files = %w[
      esd mic_darwin_coreaudio mic_freebsd mic_linux mic_linux_alsa
      mic_linux_oss mic_o2 mic_sol2 mic_sp mic_sun4 na
      portaudio pulseaudio netaudio
    ].map{|e| "#{source_root}/src/adin/adin_#{e}.c" }
    exclude_adin_files << "#{source_root}/src/adin/pa"

    sub.source_files  = "#{source_root}/{src,include}/**/*.{h,c}"

    sub.exclude_files = exclude_adin_files
    sub.header_mappings_dir = "#{source_root}/include"
    sub.libraries     = 'z'
  end

  s.subspec 'libjulius' do |sub|
    source_root = "julius-#{s.version}/libjulius"

    sub.source_files = "#{source_root}/{src,include}/**/*.{h,c}"

    sub.header_mappings_dir  = "#{source_root}/include"
    sub.xcconfig = {
      'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/Headers/Private/Julius"'
    }
    sub.dependency 'Julius/libsent'
  end

  s.resource_bundles = {
    'Julius' => [
      'Pod/Assets/*.png',
      'Pod/Assets/models/lang_m/*',
      'Pod/Assets/models/phone_m/*',
      'Pod/Assets/*.jconf'
    ]
  }
end
