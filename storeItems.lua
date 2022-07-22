
outChest = peripheral.wrap("REPLACE_WITH_OUTPUT_CHEST")

function getTableLength(T)
	local lengthNum = 0
	for k, v in pairs(T) do
		lengthNum = lengthNum + 1
	end
	return lengthNum
end

function storeItems()
	local boxes = peripheral.getNames()
	local invs = {}
	local selfList = peri.list()
	for selfSlot, selfItem in pairs(selfList) do
		for _, name in pairs(boxes) do
			if peripheral.hasType(name, "inventory") then
				table.insert(invs, name)
			end
		end
		local invsLen = getTableLength(invs)
		--via hash
		local hash = 0
		local stringToHash = selfItem.name
		for c in stringToHash:gmatch"." do
			hash = hash + string.byte(c)
		end
		hash = (hash % invsLen) + 1
		outChest.pushItems(invs[hash], selfSlot, selfItem.count)
		--fallback dump
		local itemDet = outChest.getItemDetail(selfSlot)
		if itemDet then
			for _, name in pairs(invs) do
				outChest.pushItems(name, selfSlot, selfItem.count)
			end
		end
	end
end

storeItems()