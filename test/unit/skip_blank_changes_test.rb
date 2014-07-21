require 'test_helper'

class SkipBlankChangesTest < ActiveSupport::TestCase

  context 'PaperTrail config.skip_blank_changes option enabled' do

    setup { PaperTrail.config.skip_blank_changes = true }

    context "A field is set to blank many times" do
      should 'Record only one version' do
        
        @animal = Animal.create :name => nil
        @animal.update_attributes :name => ''
        @animal.update_attributes :name => ' '
        @animal.update_attributes :name => nil
        @animal.update_attributes :name => ''
        @animal.update_attributes :name => '  '
        
        assert_equal 1, @animal.versions.count
      
      end
    end

    context 'One field is set to empty string among other regular field changes' do
      should 'record a version with only the content changed' do

        @article = Article.create title: 'Under the sea', content: 'During the first decade...', abstract: 'blabla'
        @article.update_attributes({ content: 'Nothing to say', abstract: '   ' })
        
        assert_equal 2, @article.versions.count
        assert_equal({"content"=>["During the first decade...", "Nothing to say"]}, @article.versions.last.changeset)

      end
    end
  end
end
