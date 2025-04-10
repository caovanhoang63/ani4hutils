import {cookies} from "next/headers";
import {NextResponse} from "next/server";

export default async  function POST()  {
    (await cookies()).delete("accessToken");
    return NextResponse.json({ status: 201 });
}