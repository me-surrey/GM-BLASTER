///save_player_ship(name)
file_name = argument0;

// delete if file already exists
if file_exists(string(file_name))
{
    file_delete(string(file_name));
}

// create the settings file
ini_open(string(file_name));

// save ship information
ini_write_string("ship", "type", object_get_name(global.ship.object_index));
ini_write_real("ship", "shield", global.ship.shield);
ini_write_real("ship", "max_shield", global.ship.max_shield);
ini_write_real("ship", "armor", global.ship.armor);
ini_write_real("ship", "max_armor", global.ship.max_armor);
ini_write_real("ship", "hull", global.ship.hull);
ini_write_real("ship", "max_hull", global.ship.max_hull);
ini_write_real("ship", "speed", global.ship.movement_speed);
ini_write_real("ship", "max_speed", global.ship.max_movement_speed);
ini_write_real("ship", "ship_slots", global.ship.ship_slots);

// save the ship slots and the weapons
for (i = 0; i <= global.ship.ship_slots -1; i++)
{
    if instance_exists(global.ship.slot[i])
    {
        ini_write_string("slots", string(i), object_get_name(global.ship.slot[i].object_index));

        // No need to save ammo for power type guns as they recharge and will be loaded always full
        if object_get_parent(global.ship.slot[i].object_index) != o_parent_power_gun
        {
            ini_write_real("slots", string(i) + "_ammo", global.ship.slot[i].ammo);
        }
    }
    else        // ALTERNATIVE would be to instantiate the dummy gun in the DIE code of the gun that is being destroyed... not much difference i guess
    {
        // if there is nothing on this slot insert dummy gun information
        ini_write_string("slots", string(i), "o_ship_0" + string(i) + "_dummyGun");
        // write 0 for ammo
        ini_write_real("slots", string(i) + "_ammo", 0);
    }
    // save mont points for the guns as well
    ini_write_real("slots", string(i) + "_mount_x", global.ship.ship_mount_x[i]);
    ini_write_real("slots", string(i) + "_mount_y", global.ship.ship_mount_y[i]);
}

// close the file
ini_close();
