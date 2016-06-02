// Automatic injection of HDAU properties

// Note: Only for Haswell and Broadwell

DefinitionBlock("", "SSDT", 2, "hack", "HDAU", 0)
{
    External(_SB.PCI0.HDAU, DeviceObj)
    External(RMCF.AUDL, IntObj)

    If (CondRefOf(_SB.PCI0.HDAU))
    {
        // inject properties for audio
        Method(_SB.PCI0.HDAU._DSM, 4)
        {
            If (Ones == \RMCF.AUDL) { Return(0) }
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Local0 = Package()
            {
                "layout-id", Buffer(4) {  },
                "hda-gfx", Buffer() { "onboard-1" },
            }
            CreateDWordField(DerefOf(Local0[1]), 0, AUDL)
            AUDL = \RMCF.AUDL
            Return(Local0)
        }
    }
}
//EOF
