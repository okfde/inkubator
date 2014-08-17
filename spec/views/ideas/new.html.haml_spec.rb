require 'spec_helper'

describe "ideas/new" do
  before(:each) do
    assign(:idea, stub_model(Idea,
      :string => "",
      :text => "",
      :text => "",
      :text => "",
      :text => "",
      :integer => ""
    ).as_new_record)
  end

  it "renders new idea form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", ideas_path, "post" do
      assert_select "input#idea_string[name=?]", "idea[string]"
      assert_select "input#idea_text[name=?]", "idea[text]"
      assert_select "input#idea_text[name=?]", "idea[text]"
      assert_select "input#idea_text[name=?]", "idea[text]"
      assert_select "input#idea_text[name=?]", "idea[text]"
      assert_select "input#idea_integer[name=?]", "idea[integer]"
    end
  end
end
