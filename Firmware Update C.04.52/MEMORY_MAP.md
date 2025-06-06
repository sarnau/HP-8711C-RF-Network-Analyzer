# Memory MAP of the system

	00000000-00FFFFFF     BootROM Area
		00000000-0003FFFF BootROM (256KB)
		00040000-00FFFFFF 3x Mirrored
	01000000-0101ffff     ic_non_vol_sram
	05900000-05903fff     ic_dsp_sram
	08800000-089fffff     ic_NoVol
	10000000-1fffffff     mapped IO
	20000000-2fffffff     mapped IO2
	40000000-7fffffff     FLASH Area
		40000000-         Memory (Flash) (4MB)
		40000000-403928f7 Firmware
		403928f8-403bffff Empty
		403c0000-403c68d3 Calibration Data
		403c68d3-403fffff Empty
		40400000-         255x Mirrored
	80000000-beffffff     unmapped (quasi random data)
	bf000000-             Triggers a system panic
	bffe0000-bffdffff     ic_shared_dram
	c0000000-ffffffff     Memory (DRAM) (16MB)
		c0000000-c0ffffff ic_simm_ram (ic_simm_test() only tests the first 2MB)
		c1000000-c1ffffff unmapped (quasi random data)
		c2000000-         31x Mirrored
