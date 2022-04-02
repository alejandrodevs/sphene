# frozen_string_literal: true

RSpec.describe Sphene::Attributes do
  let(:user) do
    Class.new do
      include Sphene::Attributes
    end
  end

  before do
    stub_const("User", user)
  end

  subject { User.new }

  describe ".attribute" do
    it "adds attribute to definition" do
      expect { User.attribute :name, Sphene::Types::String }
        .to change(User, :attributes)
        .from({}).to({ name: { type: Sphene::Types::String } })
    end

    it "defines getter method" do
      User.attribute :name, Sphene::Types::String
      expect(subject).to respond_to(:name)
    end

    it "defines setter method" do
      User.attribute :name, Sphene::Types::String
      expect(subject).to respond_to(:name=)
    end
  end

  describe ".inherited" do
    before do
      User.class_eval do
        attribute :name, Sphene::Types::String
      end

      stub_const("UserInherited", Class.new(User) do
        attribute :roles, Sphene::Types::Array, default: []
      end)
    end

    it "inherits attributes definition" do
      expect(UserInherited.attributes).to eql(
        {
          name: { type: Sphene::Types::String },
          roles: { type: Sphene::Types::Array, default: [] }
        }
      )
    end
  end

  describe ".attributes" do
    context "when attributes have been added" do
      before do
        User.class_eval do
          attribute :name, Sphene::Types::String
          attribute :roles, Sphene::Types::Array, default: []
        end
      end

      it "contains attributes definition" do
        expect(User.attributes).to eql(
          {
            name: { type: Sphene::Types::String },
            roles: { type: Sphene::Types::Array, default: [] }
          }
        )
      end
    end

    context "when attributes have not been added" do
      it "contains empty definition" do
        expect(User.attributes).to eql({})
      end
    end
  end

  describe "#new" do
    before do
      User.class_eval do
        attribute :name, Sphene::Types::String
      end
    end

    context "when no attributes passed" do
      it "initializes empty attributes" do
        user = User.new
        expect(user.name).to be nil
      end
    end

    context "when attributes passed" do
      it "initializes attributes" do
        user = User.new(name: "Foo")
        expect(user.name).to eql "Foo"
      end
    end

    context "when invalid attributes passed" do
      it "raises InvalidAttributeNameError" do
        expect { User.new(name: "Foo", power: 10) }.to raise_error(
          Sphene::InvalidAttributeNameError,
          "Invalid attribute name power"
        )
      end
    end
  end

  describe "#assign_attributes" do
    before do
      User.class_eval do
        attribute :name, Sphene::Types::String
      end
    end

    subject { User.new(name: "Foo") }

    it "updates attributes" do
      subject.assign_attributes({ name: "Bar" })
      expect(subject.name).to eql "Bar"
    end
  end

  describe "#attributes" do
    before do
      User.class_eval do
        attribute :name, Sphene::Types::String
        attribute :age, Sphene::Types::Integer
      end
    end

    subject { User.new(name: "Foo") }

    it "returns attributes hash" do
      expect(subject.attributes).to eql({ name: "Foo", age: nil })
    end
  end

  describe "#read_attribute" do
    before do
      User.class_eval do
        attribute :age, Sphene::Types::Integer
        attribute :name, Sphene::Types::String
        attribute :roles, Sphene::Types::Array, default: []
        attribute :vname, Sphene::Types::Array, default: -> { name }
      end
    end

    subject { User.new(name: "Foo") }

    context "when has a value" do
      it "returns attribute value" do
        expect(subject.read_attribute(:name)).to eql "Foo"
      end
    end

    context "when has default value" do
      context "when is not a proc" do
        it "returns default value" do
          expect(subject.read_attribute(:roles)).to eql []
        end
      end

      context "when is a proc" do
        it "returns default result" do
          expect(subject.read_attribute(:vname)).to eql "Foo"
        end
      end
    end

    context "when has not value" do
      it "returns nil" do
        expect(subject.read_attribute(:age)).to be nil
      end
    end

    context "when is invalid" do
      it "raises InvalidAttributeNameError" do
        expect { subject.read_attribute(:speed) }.to raise_error(
          Sphene::InvalidAttributeNameError,
          "Invalid attribute name speed"
        )
      end
    end
  end

  context "#write_attribute" do
    before do
      User.class_eval do
        attribute :age, Sphene::Types::Integer
        attribute :name, Sphene::Types::String
      end
    end

    context "when is valid" do
      it "assigns attribute value" do
        subject.write_attribute(:name, "Bar")
        expect(subject.name).to eql "Bar"
      end

      it "casts value when read attribute" do
        subject.write_attribute(:age, "10")
        expect(subject.age).to be 10
      end

      it "casts value lazily" do
        subject.write_attribute(:age, "10")
        attribute = subject.instance_variable_get(:@attributes)[:age]
        expect(attribute.instance_variable_get(:@value_before_cast)).to eql "10"

        expect { subject.age }
          .to change { attribute.instance_variable_get(:@value) }
          .from(nil).to(10)
      end
    end

    context "when is invalid" do
      it "raises InvalidAttributeNameError" do
        expect { subject.write_attribute(:speed, 10) }.to raise_error(
          Sphene::InvalidAttributeNameError,
          "Invalid attribute name speed"
        )
      end
    end
  end
end
