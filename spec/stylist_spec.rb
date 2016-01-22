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
      test_stylist = create_test_stylist()
      test_stylist.save()
      expect(test_stylist.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('saves the stylist to the database') do
      test_stylist = create_test_stylist()
      test_stylist.save()
      expect(Stylist.all()).to(eq([test_stylist]))
    end
  end

  describe('.all') do
    it('returns an empty array at first') do
      expect(Stylist.all()).to(eq([]))
    end
  end

  describe('.sort_by') do
    it('sorts the stylists by a specified column') do
      julia_stiles = create_test_stylist()
      julia_stiles.save()
      harry_styles = create_second_stylist()
      harry_styles.save()
      expect(Stylist.sort_by('last_name', 'ASC')).to(eq([julia_stiles, harry_styles]))
    end
  end

  describe('.find') do
    it('finds a stylist by their id number') do
      test_stylist = create_test_stylist()
      test_stylist.save()
      expect(Stylist.find(test_stylist.id())).to(eq(test_stylist))
    end
  end

  describe('#clients') do
    it("returns a list of the stylist's clients") do
      test_stylist = create_test_stylist()
      test_stylist.save()
      test_client = create_test_client(test_stylist.id())
      test_client.save()
      second_client = create_second_client(test_stylist.id())
      second_client.save()
      expect(test_stylist.clients()).to(eq([test_client, second_client]))
    end
  end

  describe('#update') do
    it('updates a specified attribute of the object') do
      test_stylist = create_test_stylist()
      test_stylist.save()
      test_stylist.update({
        :first_name => 'Door'
        })
      updated_stylist = Stylist.find(test_stylist.id())
      expect(updated_stylist.first_name()).to(eq('Door'))
      expect(updated_stylist.last_name()).to(eq(test_stylist.last_name()))
    end
  end

  describe('#delete') do
    it('lets you delete a stylist from the database') do
      test_stylist = create_test_stylist()
      test_stylist.save()
      second_stylist = create_second_stylist()
      second_stylist.save()
      test_stylist.delete()
      expect(Stylist.all()).to(eq([second_stylist]))
    end
  end
end
