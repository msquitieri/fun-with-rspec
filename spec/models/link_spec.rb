require 'spec_helper'

describe Link do
  before(:each) do
  	@link = FactoryGirl.create(:link)
  end

  it "has a url" do
    @link.url.should be_present
  end

  it "has a score" do
    @link.score.should be_present
  end

  it "belongs to a user" do
  	user = FactoryGirl.create(:user)
  	user.links << @link

  	@link.user.should == user
  end

  context "with comments" do
  	before(:each) do
  		@link = FactoryGirl.create(:link_with_comment)
  	end

    it "has a comment" do
      @link.comments.count.should == 1
    end

    it "updates its cumulative score when a comment gets a score" do
      3.times { @link.comments << FactoryGirl.create(:comment, score: 10, link:@link) }
      
      comment = @link.comments.first
      4.times { comment.vote_up }
      comment.save
      
      @link.save
      @link.reload
      
      @link.score.should == 35
    end
  end
end
