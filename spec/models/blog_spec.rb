require 'rails_helper'

RSpec.describe Blog, :type => :model do
  
  describe Blog do

	  
	  before { @blog = user.blogs.build(title: "First Blog", content: "Just checking the blog out") }

	  subject { @blog }

	  it { should respond_to(:title) }
	  it { should respond_to(:content) }
	  it { should respond_to(:user_id) }
	  it { should respond_to(:user) }
	  its(:user) { should eq user }

	  it { should be_valid }
	end
end
