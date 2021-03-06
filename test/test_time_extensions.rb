require 'helper'

class TestTimeExtensions < Test::Unit::TestCase
  
  should "know what a weekend day is" do
    assert(Time.parse("April 9, 2010 10:30am").weekday?)
    assert(!Time.parse("April 10, 2010 10:30am").weekday?)
    assert(!Time.parse("April 11, 2010 10:30am").weekday?)
    assert(Time.parse("April 12, 2010 10:30am").weekday?)
  end
  
  should "know a weekend day is not a workday" do
    assert(Time.parse("April 9, 2010 10:45 am").workday?)
    assert(!Time.parse("April 10, 2010 10:45 am").workday?)
    assert(!Time.parse("April 11, 2010 10:45 am").workday?)
    assert(Time.parse("April 12, 2010 10:45 am").workday?)
  end
  
  should "know a holiday is not a workday" do
    BusinessTime::Config.reset
    
    BusinessTime::Config.holidays << Date.parse("July 4, 2010")
    BusinessTime::Config.holidays << Date.parse("July 5, 2010")
    
    assert(!Time.parse("July 4th, 2010 1:15 pm").workday?)
    assert(!Time.parse("July 5th, 2010 2:37 pm").workday?)
  end
  
  
  should "know the beginning of the day for an instance" do
    first = Time.parse("August 17th, 2010, 11:50 am")
    expecting = Time.parse("August 17th, 2010, 9:00 am")
    assert expecting == first.beginning_of_workday
  end
  
  should "know the end of the day for an instance" do
    first = Time.parse("August 17th, 2010, 11:50 am")
    expecting = Time.parse("August 17th, 2010, 5:00 pm")
    assert expecting == first.end_of_workday
  end
  
end