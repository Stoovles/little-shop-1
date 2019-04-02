require "rails_helper"

RSpec.describe Item do, type: :model do
  before :each do
    @u4 = User.create(name: "Sibbie Cromett",address: "0 Towne Avenue",city: "Birmingham",state: "Alabama",zipcode: 35211,email: "scromett3@github.io",password:"fEFJeHdT1K", enabled: true, role:1)
    @u8 = User.create(name: "Tonya Baldock",address: "5 Bellgrove Crossing",city: "Yakima",state: "Washington",zipcode: 98902,email: "tbaldock7@wikia.com",password:"GN2dr6VfS", enabled: true, role:1)

    @i1 = @u4.items.create(item_name: "W.L. Weller Special Reserve",image: "http://www.buffalotracedistillery.com/sites/default/files/Weller_CYPB_750ml_front_LoRes.png",price: 20.0,inventory: 4, description:"A sweet nose with a presence of caramel. Tasting notes of honey, butterscotch, and a soft woodiness. It's smooth, delicate and calm. Features a smooth finish with a sweet honeysuckle flair.",enabled: true)
    @i2 = @u4.items.create(item_name: "W.L. Weller C.Y.P.B.",image: "http://www.buffalotracedistillery.com/sites/default/files/weller%20special%20reserve%20brand%20page%5B1%5D.png",current_price: 35.0,inventory: 30, description:"A light aroma with citrus and oak on the nose. The palate is well rounded and balanced, with a medium-long finish and hints of vanilla.",enabled: true)
    @i3 = @u8.items.create(item_name: "Bulleit Bourbon",image: "https://www.totalwine.com/media/sys_master/twmmedia/h5c/hed/11635356794910.png",current_price: 22.0,inventory: 42, description:"Medium amber in color, with gentle spiciness and sweet oak aromas. Mid-palate is smooth with tones of maple, oak, and nutmeg. Finish is long, dry, and satiny with a light toffee flavor.",enabled: true)
    @i4 = @u4.items.create(item_name: "Stagg Jr.",image: "https://www.totalwine.com/media/sys_master/twmmedia/hd3/h4f/10678919528478.png",current_price: 40.0,inventory: 30, description:"Rich, sweet, chocolate and brown sugar flavors mingle in perfect balance with the bold rye spiciness. The boundless finish lingers with hints of cherries, cloves and smokiness.",enabled: true)
    @i5 = @u8.items.create(item_name: "George T. Stagg",image: "http://www.buffalotracedistillery.com/sites/default/files/Antique-GTS_0.png",current_price: 85.0,inventory: 47, description:"Lush toffee sweetness and dark chocolate with hints of vanilla, fudge, nougat and molasses. Underlying notes of dates, tobacco, dark berries, spearmint and a hint of coffee round out the palate.",enabled: true)
    @i6 = @u4.items.create(item_name: "Old Forester 1910 Old Fine Whisky",image: "https://static.oldforester.com/app/uploads/2017/04/25181857/1920-2017.png",current_price: 45.0,inventory: 35, description:"A double barreled Bourbon creating a smooth mingling of sweet oatmeal raisin cookie and milk chocolate, caramel corn, and evolving spice that lead into a refined, charred oak finish.",enabled: true)
    @i7 = @u8.items.create(item_name: "Woodford Reserve Kentucky Straight Bourbon",image: "https://www.totalwine.com/media/sys_master/twmmedia/h57/h8d/11276299108382.png",current_price: 30.0,inventory: 43, description:"Clean, brilliant honey amber. Heavy with rich dried fruit, hints of mint and oranges covered with a dusting of cocoa. Faint vanilla and tobacco spice. Rich, chewy, rounded and smooth, with complex citrus, cinnamon and cocoa. Toffee, caramel, chocolate and spice notes abound. Silky smooth, almost creamy at first with a long, warm satisfying tail.",enabled: true)
    @i8 = @u4.items.create(item_name: "Four Roses Single Barrel",image: "https://www.totalwine.com/media/sys_master/twmmedia/h2d/h6e/11152774365214.png",current_price: 43.0,inventory: 30, description:"Dried spice, pear, cocoa, vanilla & maple syrup. Hints of ripe plum & cherries, robust, full body, mellow. Smooth & delicately long.",enabled: true)
    @i9 = @u4.items.create(item_name: "Angel's Envy Kentucky Straight Bourbon finished in Port Wine Barrels",image: "https://d256619kyxncpv.cloudfront.net/gui/img/2015/09/17/13/2015091713_angels_envy_bourbon_original.png",current_price: 55.0,inventory: 27, description:"Gold color laced with reddish amber hues, nearly copper in tone. You’ll detect notes of subtle vanilla, raisins, maple syrup and toasted nuts. Vanilla, ripe fruit, maple syrup, toast and bitter chocolate. Clean and lingering sweetness with a hint of Madeira that slowly fades.",enabled: true)
    @i10 = @u8.items.create(item_name: "Laws Four Grain Straight Bourbon",image: "https://static.whiskybase.com/storage/whiskies/6/3/733/177713-normal.png",current_price: 60.0,inventory: 43, description:"Aromas of orange blossom compliment notes of black tea, honey, and dusty pepper on the nose. Flavors of pekoe tea, orange peel, cinnamon, and vanilla custard dominate the palate. Hints of sweet tobacco and spice lead to a rich, dry finish.",enabled: true)
  end

  context "items index statistics" do
    describe ".popular_five" do
      it "should list the 5 most popular items" do
        expected = [@i1,@i3,@i5,@i7,@i8]
        expect(Item.popular_five).to eq(expected)
      end
    end

    describe ".unpopular_five" do
      it "should list the 5 least popular items" do
        expected = [@i2,@i4,@i6,@i9,@i10]
        expect(Item.unpopular_five).to eq(expected)
      end
    end
  end

  context "item show page" do
    describe ".quant_sold" do
      it "should return the total quantity of an item shipped" do
        expect(@i1.quant_sold).to eq(5) #create orders/orderitems
      end
    end

    describe ".avg_fulfill_time" do
      it "should calculate average time to fulfill item" do
        expect(@i1.avg_fulfill_time).to eq()
        expect(@i4.avg_fulfill_time).to eq()
      end
    end
  end
end
