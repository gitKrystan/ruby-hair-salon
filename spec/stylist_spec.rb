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
end
