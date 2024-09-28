#include <stdio.h>
#include <string.h>
#include <sys/utsname.h>
#include <dlfcn.h>  // Include this for dlsym and RTLD_NEXT

// Manually define RTLD_NEXT if it's not defined by your system
#ifndef RTLD_NEXT
#define RTLD_NEXT ((void *) -1)  // Fallback definition for RTLD_NEXT
#endif

// This function overrides the uname() system call.
int uname(struct utsname *buf) {
    // Get the original uname function using dlsym with RTLD_NEXT
    int (*original_uname)(struct utsname *);
    original_uname = dlsym(RTLD_NEXT, "uname");

    // Call the original uname() function to get the real system info
    int result = original_uname(buf);
    if (result != 0) {
        return result;  // Return if there's an error
    }

    // Modify all fields to fake the output of `uname -a`
    strcpy(buf->sysname, "Linux");               // Fake OS name
    strcpy(buf->nodename, "Server");             // Fake hostname
    strcpy(buf->release, "2.6.31.8");            // Fake kernel version
    strcpy(buf->version, "#2 Fri Mar 11 17:09:19 CST 2016");  // Fake build version
    strcpy(buf->machine, "armv5tel");            // Fake architecture
    // strcpy(buf->domainname, "GNU/Linux");        // Fake domain name (GNU/Linux)

    return 0;  // Success
}
