
/* IMPORT */

const fs = require ( 'fs' ),
      ls = require ( 'ls' ),
      njds = require ( 'nodejs-disks' );

/* LIST */

const list = { items: [] },
      volumes = ls ( '/Volumes/*' );

njds.drives ( ( err, drives ) => {

  njds.drivesDetail ( drives, ( err, data ) => {

    for ( let {mountpoint, drive} of data ) {

      if ( !/^\/Volumes\//.test ( mountpoint ) ) continue;
      if ( /^\/Volumes\/BOOTCAMP/.test ( mountpoint ) ) continue;

      const volume = volumes.find ( volume => volume.full.startsWith ( mountpoint ) );

      if ( !volume ) continue;

      const pathParts = drive.match ( /(\/dev\/disk\d+)s\d+/ );

      list.items.push ({
        title: volume.name,
        arg: pathParts[1]
      });

    }

    fs.writeFileSync ( 'list.json', JSON.stringify ( list, undefined, 2 ) );

  });

});
