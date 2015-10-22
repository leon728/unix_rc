#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>        /* For mode constants */
#include <fcntl.h>           /* For O_* constants */


typedef unsigned char uint8;
typedef unsigned short uint16;

#define LC_NUM_OF_SLOTS 10
#define LC_NUM_OF_PORTS 7

#define SHM_VDSL_LOOPGUARD	"/vdsl_lg_vlan_count"

typedef struct {
	uint8 uniVlan_count_port[LC_NUM_OF_SLOTS][LC_NUM_OF_PORTS];
	uint16 uniVlan_count_slot[LC_NUM_OF_SLOTS];
} VLAN_SIZE_S;

static VLAN_SIZE_S *vlanSize;


static void vdsl_loop_guard_port_shm()
{
	int shmfd;
	
	shmfd = shm_open(SHM_VDSL_LOOPGUARD, O_CREAT | O_EXCL | O_RDWR, 0777);
	if(shmfd < 0) {
		printf(" %s(): shm_open() failed\n", __func__);
		return;
	}
	
	ftruncate(shmfd, sizeof(VLAN_SIZE_S));
	vlanSize = mmap(NULL, sizeof(VLAN_SIZE_S), PROT_WRITE|PROT_READ, MAP_SHARED, shmfd, 0);
}

int main()
{
	vdsl_loop_guard_port_shm();

	return 0;
}
