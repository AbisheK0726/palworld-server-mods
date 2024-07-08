local palConfig = {
	-- Change those values for different mod name, mod version or game version
	palModName = "MaxStackCount",
	palModVersion = "1.2",
	palGameVersion = "0.2.0.6",
	palUE4SSVersion = "3.0.1",
	-- Those are generic for every mod and don't need to be changed
	palClientRegisterHook = false,
	palServerRegisterHook = false,
	palRedColorWrapperFront = "\27[31m",
	palRedColorWrapperBack = "\27[0m\n",
	-- Int32 max is 2147483647
	palMaxStackCount = 999999999
}
return palConfig
