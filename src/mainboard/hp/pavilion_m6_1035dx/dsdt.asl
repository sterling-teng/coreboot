/* SPDX-License-Identifier: GPL-2.0-only */

#include "mainboard.h"

/* DefinitionBlock Statement */
#include <acpi/acpi.h>
DefinitionBlock (
	"DSDT.AML",		/* Output filename */
	"DSDT",			/* Signature */
	0x02,			/* DSDT Revision, needs to be 2 for 64bit */
	OEM_ID,
	ACPI_TABLE_CREATOR,
	0x00010001		/* OEM Revision */
	)
{	/* Start of ASL file */
	/* #include <arch/x86/acpi/debug.asl> */	/* Include global debug methods if needed */

	/* Globals for the platform */
	#include "acpi/mainboard.asl"

	/* Describe the USB Overcurrent pins */
	#include "acpi/usb_oc.asl"

	/* PCI IRQ mapping for the Southbridge */
	#include <southbridge/amd/agesa/hudson/acpi/pcie.asl>

	/* Describe the processor tree (\_SB) */
	#include <cpu/amd/agesa/family15tn/acpi/cpu.asl>

	/* Describe the supported Sleep States for this Southbridge */
	#include <southbridge/amd/common/acpi/sleepstates.asl>

	/* Describe the Sleep Methods (WAK, PTS, GTS, etc.) for this platform */
	#include "acpi/sleep.asl"

	Scope(\_SB) {
		/* global utility methods expected within the \_SB scope */
		#include <arch/x86/acpi/globutil.asl>

		/* Describe IRQ Routing mapping for this platform (within the \_SB scope) */
		#include "acpi/routing.asl"

		Device(PCI0) {
			/* Describe the AMD Northbridge */
			#include <northbridge/amd/agesa/family15tn/acpi/northbridge.asl>

			/* Describe the AMD Fusion Controller Hub Southbridge */
			#include <southbridge/amd/agesa/hudson/acpi/fch.asl>

		}

		/* Describe PCI INT[A-H] for the Southbridge */
		#include <southbridge/amd/agesa/hudson/acpi/pci_int.asl>

	}   /* End Scope(_SB)  */

	Scope(\_SB.PCI0.LIBR) {
		#include "acpi/ec.asl"
	}

	/* Describe SMBUS for the Southbridge */
	#include <southbridge/amd/agesa/hudson/acpi/smbus.asl>

	/* Define the General Purpose Events for the platform */
	#include "acpi/gpe.asl"

	/* Define the Thermal zones and methods for the platform */
	#include "acpi/thermal.asl"

	/* Define the System Indicators for the platform */
	#include "acpi/si.asl"

}
/* End of ASL file */
