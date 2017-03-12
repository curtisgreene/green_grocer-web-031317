
def consolidate_cart(cart)
  # code here
  new_cart = {}
  cart.each do |items|
    items.each do |name, item_hash|
      unless new_cart[name]
        new_cart[name] = item_hash
        new_cart[name][:count] = 0
      end
      new_cart[name][:count] += 1
    end
  end
  new_cart
end

def apply_coupons(cart, coupons)
  couponed_items= {}
  coupons.each do |coupon_hash|
    cart.each do |name, item_hash|
      if name == coupon_hash[:item] && item_hash[:count] >= coupon_hash[:num]
        item_hash[:count] = item_hash[:count] - coupon_hash[:num]
        new_name = coupon_hash[:item] + " W/COUPON"
        couponed_items[new_name] = { :price => coupon_hash[:cost],
                                     :count => 1,
                                     :clearance => item_hash[:clearance] }
      end
    end
  end
  cart.merge(couponed_items)
end

def apply_clearance(cart)
  # code here
  cart.each do |name, item_hash|
    if item_hash[:clearance] == true
      new_price = item_hash[:price] * 0.8
      item_hash[:price] = new_price.round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  colsolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(colsolidated_cart, coupons)
  discounted_cart = apply_clearance(couponed_cart)
  total = 0
  discounted_cart.each do |name, attributes|
    total += attributes[:price] * attributes[:count]
  end
  total = total * 0.9 if total > 100
  total
end
