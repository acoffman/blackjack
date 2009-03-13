#This script will run all the the Rspec tests that I wrote 
#They Reside in the /spec/ directory and follow the naming convention
# "filename_spec.rb" although the script could easily be changed to 
# fit another set of requirements.

#This is the directory that your Rspec tests reside in, relative to the 
#position of this helper script
TEST_DIR = ('/spec/')

#Change our working directory to where our tests reside
Dir.chdir((File.dirname(__FILE__)+TEST_DIR))

#We only want to grab ruby files and I name mine /something/_spec.rb 
#but this could easily be changed if you had a different naming 
#convention
tests = Dir.glob('*_spec.rb')

#Run each test on the command line, capturing the results
results = ""
tests.each do |curr_test|
	results << %x{spec --format specdoc #{curr_test}}
end

#Grab the result line of each test so that wwe can calculate the total
#number of tests and see if any of them failed
result_lines = results.scan(/^[0-9]+ examples*, [0-9]+ failures*$/)

#Cycle through the result lines from each individual test
#to sum up the total number of tests and failures
total_tests = total_failures = 0
result_lines.each do |curr|
	line = curr.split(' ')
	total_tests += line[0].to_i
	total_failures += line[2].to_i
end

#Output the test results then the overall number of tests and if
#there were any failures.
puts results + "\n"
puts "Overall there were #{total_tests} total tests, #{total_failures} of which failed."
puts "The test pass rate was #{(total_tests-total_failures)/(total_tests * 1.0)*100}%"