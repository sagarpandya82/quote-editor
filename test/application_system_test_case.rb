require "test_helper"
require "capybara/rails"
require "selenium/webdriver"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  Capybara.register_driver :remote_chrome do |app|
    browser_options = Selenium::WebDriver::Chrome::Options.new
    browser_options.add_argument("--no-sandbox")
    browser_options.add_argument("--disable-dev-shm-usage")
    browser_options.add_argument("--headless=new")

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: ENV.fetch("SELENIUM_REMOTE_URL", "http://chrome:4444/wd/hub"),
      options: browser_options
    )
  end

  driven_by :remote_chrome

  setup do
    if ENV["GITHUB_ACTIONS"] == "true"
      # CI: Rails runs on the runner, so point Chrome at localhost
      Capybara.server_host = "127.0.0.1"
      Capybara.app_host = "http://127.0.0.1:#{Capybara.server_port}"
    else
      # Docker Compose: expose the server and use the service name on the docker network
      Capybara.server_host = "0.0.0.0"
      Capybara.app_host = "http://web:#{Capybara.server_port}"
    end
  end
end
