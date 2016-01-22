require "spec_helper"

describe(Stylist) do
  describe('#initialize') do
    it('returns an object') do
      julia_stiles = create_test_stylist()
      expect(julia_stiles.first_name()).to(eq('Julia'))
      expect(julia_stiles.last_name()).to(eq('Stiles'))
      expect(julia_stiles.phone()).to(eq('503-555-4242'))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
      julia_stiles = create_test_stylist()
      julia_stiles.save()
      expect(julia_stiles.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('.all') do
    it('returns an empty array at first') do
      expect(Stylist.all()).to(eq([]))
    end
  end
end
