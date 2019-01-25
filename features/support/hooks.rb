require 'watir'
require 'webdriver-user-agent'
require 'os'
require_relative 'utils/file_utilities'
require_relative 'utils/common'

include FileUtilities
include Common
include DataMagic

# Global variables
$current_feature_path = ''
$current_feature_name = ''
#  Get current time
time = Time.new
# converts current time into 'YYYY-MM-DD/HH.mm.ss' format to be used throughout the application
$date_and_time = "#{time.year}-#{time.month}-#{time.day}/#{time.hour}.#{time.min}.#{time.sec}"
# Path and file for the log output

LOG_FILE = if OS.windows?
             Dir.pwd + '\\log\\chromedriver.log'
           else
             Dir.pwd + '/log/chromedriver.log'
           end

Watir.default_timeout = 30
Before do |scenario|
  $current_feature_path = scenario.feature.file
  $current_feature_name = File.basename($current_feature_path)
  runtime_browser = Common.get_test_data('feature_level_config.yml', 'browser', $current_feature_name)
  @browser = init_browser(runtime_browser)
  puts "Running test #{scenario.name} with #{@browser.driver.browser} Driver"
end

After do |scenario|
  begin
    take_screenshot(scenario) if scenario.failed?
  ensure
    @browser.quit
  end
end

def init_browser(runtime_browser)
  case runtime_browser
  when 'chrome'
    begin
      load_chromedriver_path
      browser = Watir::Browser.new :chrome, switches: %w[enable-automation]
    end
  when 'phantomjs'
    begin
      load_phantomjs_path
      browser = Watir::Browser.new :phantomjs
    end
  when 'iphone_chrome'
    begin
      load_chromedriver_path
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :iphone, orientation: :portrait)
      browser = Watir::Browser.new driver
    end
  when 'ipad_chrome'
    begin
      load_chromedriver_path
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :ipad, orientation: :portrait)
      browser = Watir::Browser.new driver
    end
  when 'android_chrome'
    begin
      load_chromedriver_path
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :android_phone, orientation: :portrait)
      browser = Watir::Browser.new driver
    end
  when 'android_tablet_chrome'
    begin
      load_chromedriver_path
      driver = Webdriver::UserAgent.driver(browser: :chrome, agent: :android_tablet, orientation: :portrait)
      browser = Watir::Browser.new driver
    end
  when 'firefox'
    begin
      # load_geckodriver_path
      browser = Watir::Browser.new :firefox
    end
  else
    begin
      load_chromedriver_path
      browser = Watir::Browser.new :chrome
    end
  end
  browser.driver.manage.window.maximize
  screen_width = browser.execute_script('return screen.width;')
  screen_height = browser.execute_script('return screen.height;')
  browser.driver.manage.window.resize_to(screen_width, screen_height)
  browser.driver.manage.window.move_to(0, 0)
  browser
end

#  Takes a screenshot of the current state of the page if the scenario failed.
#  Saves screenshot in folder specified in environments/default.yml
def take_screenshot(_scenario)
  screenshot_dir = "#{FigNewton.screenshot_directory}/#{$date_and_time}"
  FileUtils.mkdir screenshot_dir unless File.directory? screenshot_dir
  encoded_img = @browser.driver.screenshot_as(:base64)
  embed("data:image/png;base64,#{encoded_img}", 'image/png')
end

def load_chromedriver_path
  # Specify the driver path
  browser_path = FigNewton.drivers.to_s
  driver = 'chromedriver.exe' if OS.windows?
  driver = 'chromedriver_mac' if OS.mac?
  driver = 'chromedriver_linux64' if OS.linux?
  chromedriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), browser_path, driver)
  Selenium::WebDriver::Chrome.driver_path = chromedriver_path
end

def load_phantomjs_path
  # Specify the driver path
  browser_path = FigNewton.drivers.to_s
  driver = 'phantomjs.exe' if OS.windows?
  driver = 'phantomjs_mac' if OS.mac?
  driver = 'phantomjs_linux64' if OS.linux?
  phantomjs_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), browser_path, driver)
  Selenium::WebDriver::PhantomJS.driver_path = phantomjs_path
end

def load_geckodriver_path
  # Specify the driver path
  browser_path = FigNewton.drivers.to_s
  if OS.windows?
    driver = OS.bits == '32' ? 'geckodriver_win32.exe' : 'geckodriver_win64.exe'
  end
  driver = 'geckodriver_mac' if OS.mac?
  driver = 'geckodriver_linux64' if OS.linux?
  geckodriver_path = File.join(File.absolute_path('../..', File.dirname(__FILE__)), browser_path, driver)
  Selenium::WebDriver::Firefox.driver_path = geckodriver_path
end
