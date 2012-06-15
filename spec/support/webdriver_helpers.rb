require "selenium-webdriver"

module WebDriverHelpers
	def wait_for_ajax
	  wait.until {$driver.execute_script "return jQuery.active == 0"}
	end

	def click locator
	  element(locator).click
	end

	def element locator
	  $driver.find_element(locator)
	end

	def element_exists locator
	  begin
	    element locator
		  true
	  rescue
	    false
	  end
	end

	def wait timeout = 20
	  Selenium::WebDriver::Wait.new(:timeout => timeout)
	end

	def go_to resource
	  uri = URI.join(HOST_URL, resource).to_s
	  $driver.navigate.to(uri)
	end

	def current_path
		URI.split($driver.current_url)[5]
	end

	def type text
	  TextTyper.new text
	end

	class TextTyper
	  def initialize text
	    @text = text
	  end

	  def into locator
	    input = element(locator)
            input.clear
	    input.send_keys @text
	  end

	  def into_wysihtml5(locator)
	    raise "only id locators are supported right now" if(!locator[:id])
	    $driver.execute_script("$('##{locator[:id]}').data('wysihtml5').editor.composer.setValue('#{@text}');")
	  end
	end
end
