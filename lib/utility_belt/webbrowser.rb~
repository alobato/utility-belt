require 'platform'

module UtilityBelt
  class WebBrowser
    def self.open(url)
      case Platform::IMPL
        when :macosx
          Kernel.system("open #{url}")
        when :mswin
          Kernel.system("start #{url}")
        when :linux
          #figure out the prefered web browser
          #debian
          if b = File.readlink("/etc/alternatives/x-www-browser") rescue false
            launch_linux_browser(b, url)
          #gentoo maybe
          elsif b = ENV["BROWSER"]
            launch_linux_browser(b, url)
          end
        end
    end
  
    private
    def self.launch_linux_browser(browser, url)
      if /konqueror/.match browser
        cmd = "dcop `dcop konq* | head -1` konqueror-mainwindow#1 newTab #{url}"
        Kernel.system(cmd)
      elsif /(firefox)|(swiftweasel)/.match b
        Kernel.system("#{browser} -new-tab #{url}")
      else
        Kernel.system("#{browser} #{url}")
      end
    end
  end
end

WebBrowser = UtilityBelt::WebBrowser if Object.const_defined? :IRB
