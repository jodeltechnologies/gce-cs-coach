import Link from 'next/link';
import {notFound} from 'next/navigation';
import { requireTeacher } from '../../../lib/guards';
import PracticalGuide from './PracticalGuide';
export const dynamic='force-dynamic';
export const metadata={title:'Paper 3 teaching guide'};
export default async function GuidePage({searchParams}){
 const {supabase,teacher}=await requireTeacher();
 if(!supabase)return <p>Not connected.</p>;
 if(!teacher)notFound();
 const sp=await searchParams;
 return <><p><Link href="/admin/past-papers">Browse the original past papers</Link></p><PracticalGuide initialArea={sp?.area}/></>;
}
