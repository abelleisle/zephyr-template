/*
 * Copyright (c) 2016 Intel Corporation.
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <zephyr/kernel.h>
#include <errno.h>

#include <stdint.h>
#include <zephyr/sys/cbprintf.h>

#include <pb_encode.h>
#include <pb_decode.h>
#include <messages.pb.h>

int main(void)
{
    messages_Person person = messages_Person_init_zero;

    uint8_t buffer[128];
    size_t message_length;
    bool status;

    /* Encode the messages */
    {
        messages_Person person = messages_Person_init_zero;

        /* Create a stream that will write to our buffer. */
        pb_ostream_t stream = pb_ostream_from_buffer(buffer, sizeof(buffer));

        /* Fill in the lucky number */
        person.id = 1234;

        /* Now we are ready to encode the message! */
        status = pb_encode(&stream, messages_Person_fields, &person);
        message_length = stream.bytes_written;

        /* Then just check for any errors.. */
        if (!status)
        {
            printk("Encoding failed: %s\n", PB_GET_ERROR(&stream));
            return 1;
        }
    }

    /* Decode message */
    {
        /* Allocate space for the decoded message. */
        messages_Person person = messages_Person_init_zero;

        /* Create a stream that reads from the buffer. */
        pb_istream_t stream = pb_istream_from_buffer(buffer, message_length);

        /* Now we are ready to decode the message. */
        status = pb_decode(&stream, messages_Person_fields, &person);

        /* Check for errors... */
        if (!status)
        {
            printk("Decoding failed: %s\n", PB_GET_ERROR(&stream));
            return 1;
        }

        /* Print the data contained in the message. */
        printk("Person ID: %d!\n", person.id);
    }

    return 0;
}
