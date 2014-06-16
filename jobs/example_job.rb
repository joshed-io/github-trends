require 'pushpop'

job 'Simple Math' do

  every 5.seconds

  step 'return 10' do 10 end

  step 'increase by 20' do |response|
    20 + response
  end

  step 'print out via template' do |response|
    html = template 'first_template.html.erb', response
    puts 'Hey Pushpop, let\'s do a math!'
    puts html
    html
  end

end
